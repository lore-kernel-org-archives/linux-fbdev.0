From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 04 Jul 2020 21:26:15 +0000
Subject: Re: [PATCH v1 1/1] dt-bindings: fix simple-framebuffer example
Message-Id: <20200704212615.GA1693435@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200704143544.789345-1-sam@ravnborg.org>
 <20200704143544.789345-2-sam@ravnborg.org>
 <CAMuHMdXWXk=QUbpFeX6bjwp+JWKgHqiQALTdQJgSgwBRkyvkRA@mail.gmail.com>
In-Reply-To: <CAMuHMdXWXk=QUbpFeX6bjwp+JWKgHqiQALTdQJgSgwBRkyvkRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, DRI Development <dri-devel@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>

On Sat, Jul 04, 2020 at 11:03:21PM +0200, Geert Uytterhoeven wrote:
> Hi Sam,
> 
> Thanks for your patch!
> 
> On Sat, Jul 4, 2020 at 4:37 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > Now that dt-extract-example gained support for using root nodes
> > in examples, update the example for the simple-frambuffer binding to use it.
> 
> simple-framebuffer
Thanks, will fix.

> 
> > This gives us a better example and kill a long standing warning:
> >
> > simple-framebuffer.example.dts:23.16-39.11:
> > Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> >
> > Note: To get the update dt-extract-example execute:
> > pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> > --- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> > +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> > @@ -152,28 +152,29 @@ additionalProperties: false
> >
> >  examples:
> >    - |
> > -    aliases {
> > -      display0 = &lcdc0;
> 
> Why drop the aliases example?
I did not see it had any value for the binding that the example shall
demonstrate. But it was not somthing I have given much thought of.

	Sam

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
