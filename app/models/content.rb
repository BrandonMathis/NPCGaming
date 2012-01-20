module Content
  def html_body
    parsed_body.html_safe if parsed_body
  end

  private
  def parse_textile_body
    self.parsed_body = RedCloth.new(self.body).to_html if self.body
  end
end
