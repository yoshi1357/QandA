class InquiryController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      InquiryMailer.send_mail(@inquiry).deliver
      flash[:notice] = 'お問い合わせありがとうございます。'
      redirect_to root_path
    else
      flash[:alert] = 'お問い合わせは完了していません'
      render :new
    end
  end

  private
    def inquiry_params
      params.require(:inquiry).permit(:email, :message)
    end
end
