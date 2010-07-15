From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 15 Jul 2010 19:37:00 +0000
Subject: Re: [PATCH v2] s3c-fb: Automatically calculate pixel clock when
Message-Id: <20100715123700.d7efd3a1.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4c3baddb.d37b0e0a.67e4.ffffcb55@mx.google.com>
	<20100715115238.6c90b90a.akpm@linux-foundation.org>
	<4C3F6023.5080002@gmail.com>
In-Reply-To: <4C3F6023.5080002@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org

On Thu, 15 Jul 2010 21:23:15 +0200
Maurus Cuelenaere <mcuelenaere@gmail.com> wrote:

>  Op 15-07-10 20:52, Andrew Morton schreef:
> > On Tue, 13 Jul 2010 02:05:45 +0200
> > Maurus Cuelenaere <mcuelenaere@gmail.com> wrote:
> >
> >> This patch adds a simple algorithm which calculates the pixel clock based on the
> >> video mode parameters. This is only done when no pixel clock is supplied through
> >> the platform data.
> >>
> > So..  we are to assume that there's a platform which doesn't provide
> > the pixel clock data?  Adding some information about that in the
> > changelog would have been useful.
> 
> Not exactly, this allows you to omit the pixel clock data and thus sharing the
> "algo" used for calculating it; which is done in another patch (not submitted to
> linux-fbdev, see [1]).
> 
> [1] - http://www.spinics.net/lists/linux-samsung-soc/msg02086.html
> 

That means that there's no reason to merge this patch!

So I merged "arm: samsung: remove pixclock from several boards" as well ;)
