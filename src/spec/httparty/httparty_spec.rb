describe 'httparty' do 
  it 'content-type', vcr: { cassette_name: 'jsonplaceholder/posts', :record => :new_episodes } do
                            # match_requests_on: [:body] } do 
    response = HTTParty.get('http://jsonplaceholder.typicode.com/posts/2')
    content_type = response.headers['content-type']
    expect(content_type).to match(/application\/json/)
  end 
end 