From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 11 Mar 2011 21:46:51 +0000
Subject: Re: [PATCH 1/4] ARM: PXA: PXAFB: rework pxafb overlay memory management
Message-Id: <201103112346.51471.anarsoul@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201103060030.59584.anarsoul@gmail.com>
	<1299835250-11095-1-git-send-email-anarsoul@gmail.com>
	<201103112234.10904.marek.vasut@gmail.com>
In-Reply-To: <201103112234.10904.marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 11 March 2011 23:34:10 Marek Vasut wrote:
> > +	if (ofb->usage++ = 0)
> 
> TBH I don't like this notation, it feels hard to read. Can you split that
> ofb-
> 
> >usage++ into two parts ?
> 
> Cheers

It's not deprecated by kernel codestyle, looks ok and works ok, but I'll 
change it if one more person argues against it :)

Regards
Vasily
