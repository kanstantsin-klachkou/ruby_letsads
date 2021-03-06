describe Letsads::XMLBuilder do
  let(:login)    { 'login' }
  let(:password) { 'password' }
  let(:sender)   { 'sender' }

  before do
    Letsads::Configuration.login    = login
    Letsads::Configuration.password = password
    Letsads::Configuration.sender   = sender
  end

  describe '#send_sms_xml'
    let(:phone_numbers)        { [123456789, 123456729] }
    let(:message)              { 'some_text_message' }
    let(:xml_builder)          { Letsads::XMLBuilder.new }
    let(:generated_xml_string) { xml_builder.send_sms_xml(phone_numbers, message) }

    it 'generates correct xml' do
      doc = Nokogiri::XML(generated_xml_string)

      expect(doc.xpath('//login').text).to         eq(login)
      expect(doc.xpath('//password').text).to      eq(password)
      expect(doc.xpath('//from').text).to          eq(sender)
      expect(doc.xpath('//text').text).to          eq(message)
      expect(doc.xpath('//recipient').count).to    eq(2)
      expect(doc.xpath('//recipient')[0].text).to  eq(phone_numbers[0].to_s)
      expect(doc.xpath('//recipient')[1].text).to  eq(phone_numbers[1].to_s)
    end
end
