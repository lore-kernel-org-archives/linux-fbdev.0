From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] nvidiafb: allow ignoring EDID info
Date: Fri, 23 Feb 2007 01:03:31 +0800
Message-ID: <1172163811.4198.19.camel@daplas>
References: <ephv35$4i3$1@sea.gmane.org>
	 <20070130203301.GA15067@dreamland.darkstar.lan>
	 <20070204201713.GA12867@dreamland.darkstar.lan>
	 <Pine.LNX.4.64.0702062034380.9224@pentafluge.infradead.org>
	 <cb7bb73a0702061508x767882dcia1b13f85d898b6e7@mail.gmail.com>
	 <1172101406.4217.16.camel@daplas>
	 <cb7bb73a0702220001u6acbdd95ncdc9fad10d06b421@mail.gmail.com>
	 <1172133646.4086.5.camel@daplas>
	 <cb7bb73a0702220548s55380f7fk995726ffd349823b@mail.gmail.com>
	 <1172153358.4306.17.camel@daplas>
	 <cb7bb73a0702220755y3eb2e5b1r8e7908ae0c1720c9@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751717AbXBVRAs@vger.kernel.org>
In-Reply-To: <cb7bb73a0702220755y3eb2e5b1r8e7908ae0c1720c9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc: James Simmons <jsimmons@infradead.org>, Luca Tettamanti <kronos@people.it>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org

On Thu, 2007-02-22 at 16:55 +0100, Giuseppe Bilotta wrote:
> On 2/22/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> However, I'm still getting the same snowy effects, which doesn't come
> as a surprise since the actual mode timings used are just the same ...
> 

BTW, you can also use CVT modes for nvidiafb, even if the mode in
question is not present in the EDID block.  For example:

video=nvidiafb:1024x768M@60 or 1600x1200M@60 

(The 'M' tells fb_find_mode to do a CVT calculation instead).

If you use a reduced-blanking CVT mode, it might even reduce the snow of
your DVI even at the highest resolution.  So:

video=nvidiafb:1600x1200MR@60

(The additional 'R' will do reduced-blanking CVT calculation)

Tony
