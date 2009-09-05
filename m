From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] viafb: 2D engine rewrite (and viafb patches in
 general)
Date: Sat, 5 Sep 2009 16:01:40 -0700
Message-ID: <20090905160140.7b36527f.akpm@linux-foundation.org>
References: <1251666438-5448-1-git-send-email-FlorianSchandinat@gmx.de>
	<1252097032-3568-1-git-send-email-FlorianSchandinat@gmx.de>
	<20090905161645.74a49a84@bike.lwn.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753606AbZIEXCF@vger.kernel.org>
In-Reply-To: <20090905161645.74a49a84@bike.lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jonathan Corbet <corbet@lwn.net>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

On Sat, 5 Sep 2009 16:16:45 -0600 Jonathan Corbet <corbet@lwn.net> wrote:

> On Fri,  4 Sep 2009 20:43:52 +0000
> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
> > This patch is a completly rewritten 2D engine. The engine is no longer
> > in a default state but reinitialized every time to allow usage for both
> > framebuffers regardless of their settings.
> > The whole engine handling is concentrated in a big function which takes
> > 16 parameters.
> 
> Ouch, that's a lot of parameters.  Might it be better to create a
> structure to encapsulate all of those drawing parameters?

I was wondering that.  There's less advantage to that than usual
because the call graph is not at all deep.

> On a more general level: is anybody maintaining a tree for patches to
> the viafb driver?

-mm.

>  I'm going to be doing some work here (writing a
> driver for the video capture engine), and there's patches sitting in
> Harald's tree and the OLPC tree.

As far as the rest of the world is concerned, that stuff doesn't exist.

>  It seems like a central merge point
> might be a nice thing to have.
> 
> I'd be happy to run such a tree.  I'm really *not* qualified to be
> passing judgment on patches to the framebuffer driver at this point,
> though, so I'm not sure that I'm the best person for the job.

Send 'em over.  I haven't heard anything from the original viafb
submitters for a long time.  Hopefully Florian has time to help out
with some review-n-test.
