From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] nvidiafb: allow ignoring EDID info
Date: Thu, 22 Feb 2007 20:08:43 +0100
Message-ID: <cb7bb73a0702221108r161441ebt61886ce67746f389@mail.gmail.com>
References: <ephv35$4i3$1@sea.gmane.org>
	 <Pine.LNX.4.64.0702062034380.9224@pentafluge.infradead.org>
	 <cb7bb73a0702061508x767882dcia1b13f85d898b6e7@mail.gmail.com>
	 <1172101406.4217.16.camel@daplas>
	 <cb7bb73a0702220001u6acbdd95ncdc9fad10d06b421@mail.gmail.com>
	 <1172133646.4086.5.camel@daplas>
	 <cb7bb73a0702220548s55380f7fk995726ffd349823b@mail.gmail.com>
	 <1172153358.4306.17.camel@daplas>
	 <cb7bb73a0702220755y3eb2e5b1r8e7908ae0c1720c9@mail.gmail.com>
	 <1172161290.4198.12.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751771AbXBVTIq@vger.kernel.org>
In-Reply-To: <1172161290.4198.12.camel@daplas>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: James Simmons <jsimmons@infradead.org>, Luca Tettamanti <kronos@people.it>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org

On 2/22/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> On Thu, 2007-02-22 at 16:55 +0100, Giuseppe Bilotta wrote:
> >
> > However, I'm still getting the same snowy effects, which doesn't come
> > as a surprise since the actual mode timings used are just the same ...
>
> Yes, because the EDID has only 1 mode entry. But now you can use 'fbset
> 1024x768-60' (or any mode smaller than 1600x1200-60) for example and it
> should work.

No, it doesn't. I've tried all the methods from 640x480 to 1600x1200,
and they /all/ come up snowy. This is starting to look queerer and
queerer. I've also tried changing vf min and max as you suggested:

>  You might want to change  vfmin and vfmax to 59 and 61

and even the M and MR methods which you suggested in the other email.
Since nvidiafb is being loaded from the command line because it's a
blacklisted module otherwise, I've been using the mode_option option.
However, neither the mode_option nor fbset seem to give me anything
not snowy.

Damn.

-- 
Giuseppe "Oblomov" Bilotta
