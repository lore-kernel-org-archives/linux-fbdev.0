From: aivils@latnet.lv
Date: Thu, 11 Mar 2010 06:46:25 +0000
Subject: Re: My goal
Message-Id: <1268289985.4b9891c1d28e3@online.sigmanet.lv>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.00.1003110341550.21470@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1003110341550.21470@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: James Simmons <jsimmons@infradead.org>
Cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI development list <dri-devel@lists.sourceforge.net>

Please week up James!
Over the world are around 10 versions of multiseat:
http://en.wikipedia.org/wiki/Multiseat_configuration
Microsoft Multipoint is in the count. What You will do better?
Of course i am addicted to this thing. I even created small project here:
http://sourceforge.net/projects/multiseat-gk/

You can make complete the VGAarbiter
http://www.x.org/wiki/VgaArbiter
or You can complete the proxy server of X, which is started by Tiago Vignat=
ti
and has name X address translator (xat) , but i don't have link. You need p=
roxy
if You will emulate multiple X servers on single multiheaded X server. xat
works because Peter Hutterer created multi pointer X server, which basicaly
fit for needs of multiseat. I suppose xat proxy require big changes in X
server as result development stalled.
Commercial proxy version runs since 2002 , userful.com.

Cheers,
Aivils

Cit=E7ju James Simmons <jsimmons@infradead.org>:

>
> Okay all the discussion about multiple display brings me to why I'm doing
> this. I'm attempting to revive the linux console project. I'm in a
> position to again work on this project. About 4 years ago the eproject
> managed to get multi-seat working. My goal is to get there again. My first
> goal is to get my netbook to act has a multiseat system for two. With a
> plugged
> in external montior and a USB keyboard run two concurrent X sessions both
> running OpenGL applications at the same time. I set out to do this 10
> years ago and I want to finally accomplish this.
>
> -------------------------------------------------------------------------=
-----
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Linuxconsole-dev mailing list
> Linuxconsole-dev@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linuxconsole-dev
>




