class MuutCommentsTag < Liquid::Tag
  def initialize(tag_name, muut_name, tokens)
    super
    @muut_name = muut_name
  end

  def render(context)
    muut_name = context.environments.first['site']['muut_name']
    %Q{<a href="https://muut.com/i/#{muut_name}/comments" class="muut" type="dynamic">Comments</a>}
  end
end

Liquid::Template.register_tag('muut_comments', MuutCommentsTag)