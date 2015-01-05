---
layout: post
title: "Usando Muut para Comentários"
date: 2015-01-05 16:01
comments: true
categories:
tags: comments
image: /assets/article_images/2015-01-05-usando-muut-para-comentarios/muut.png
---

## Comentários com Muut
<br>
Resolvi tomar vergonha e retomar meu projeto de Blog o.O

Para este post de retomada vou falar sobre o [Muut](http://muut.com), uma plataforma de comentarios para fórum e sites.

Assím como muitos eu utilizava o [Disqus](https://disqus.com), resolvi dar uma chance ao Muut, pois ele é diferente do Disqus em relação do modelo de negócio em sí, ultimamente o Disqus vem incluindo ads nos as vezes indesejáveis aos comentários, nada contra este tipo de modelo, porém neste caso, prefiro usar um produto que cobre pelo serviço que ele entrega, e é isso que o Muut faz.

O Muut cobra para que se possa personalizar seus comentários e você pode até personalizar a URL externa dos comentários, toda conta inicial é um Trial, e quando espirar o período trial, sua conta se transforma automaticamente em free, se quiser continuar usando os "Fru-Frus" é só pagar pela conta, isso significa que não há ads indesejados :)

Ele muito mais flexível que o Disqus.

O mais legal que achei foi o suporte a syntax highlight nos comentários para nós Devs é super útil :p

![syntax highlight](/assets/article_images/2015-01-05-usando-muut-para-comentarios/syntax_highlight.png)

Embedding é bem simples, vou explicar como configurei o Muut com o [Jekyll](http://jekyllrb.com) que é o gerador estático que estou usando neste blog.

Primeiramente, entre na pagina [do Muut](https://muut.com) e faça seu cadastro, de um nome a um fórum

Para funcionar você precisa somente linkar o Muut assim

{% highlight html %}
  <a href="https://muut.com/i/[community-name]/comments" class="muut" type="dynamic">Comments</a>
<script src="//cdn.muut.com/1/moot.min.js"></script>
{% endhighlight %}

Para itegrar ao Jekyll adaptei [este](https://github.com/pelargir/octopress-muut) ao meu contexto.
<br>
Este código no arquivo muut.rb na pasta _plugins

{% highlight ruby %}
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
{% endhighlight %}

<br>
Adicionei muut_name no _config.yml

{% highlight ruby %}
  muut_name: [community-name]
{% endhighlight %}

<br>
No layout dos posts

{% highlight liquid %}
  {{ "{%" }} if site.muut_name and page.comments == true %}
  <section>
    {{ "{%" }} muut_comments %}
  </section>
{{ "{%" }} endif %}
{% endhighlight %}

<br>
No include javascript

{% highlight html %}
  <script src="//cdn.muut.com/1/moot.min.js"></script>
{% endhighlight %}

E já está tudo funcionando :)

Pode testar o Muut aqui em baixo. <3
