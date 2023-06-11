# app/controllers/passwords_controller.rb
class PasswordsController < ApplicationController
    before_action :redirect_if_authenticated
  
    def create
      @user = User.find_by(email: params[:user][:email].downcase)
      if @user.present?
        if @user.confirmed?
          @user.send_password_reset_email!
          redirect_to root_path, notice: "<div style='background-color: blue; color: white;'>If that user exists we've sent instructions to their email.</div>".html_safe

        else
          redirect_to new_confirmation_path, alert: "<div style='background-color: red; color: white;'>Please confirm your email first.</div>".html_safe

        end
      else
        redirect_to root_path, notice: "<div style='background-color: blue; color: white;'>If that user exists we've sent instructions to their email.</div>".html_safe

      end
    end
  
    def edit
      @user = User.find_signed(params[:password_reset_token], purpose: :reset_password)
      if @user.present? && @user.unconfirmed?
        redirect_to new_confirmation_path, alert: "<div style='background-color: red; color: white;'>You must confirm your email before you can sign in.</div>".html_safe

      elsif @user.nil?
        redirect_to new_password_path, alert: "<div style='background-color: red; color: white;'>Invalid or expired token.</div>".html_safe

      end
    end
  
    def new
    end
  
    def update
      @user = User.find_signed(params[:password_reset_token], purpose: :reset_password)
      if @user
        if @user.unconfirmed?
          redirect_to new_confirmation_path, alert: "<div style='background-color: red; color: white;'>You must confirm your email before you can sign in.</div>".html_safe
        elsif @user.update(password_params)
          redirect_to login_path, notice: "Sign in."
        else
          flash.now[:alert] = @user.errors.full_messages.to_sentence
          render :edit, status: :unprocessable_entity
        end
      else
        flash.now[:alert] = "<div style='background-color: red; color: white;'>Invalid or expired token.</div>".html_safe
        
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
  