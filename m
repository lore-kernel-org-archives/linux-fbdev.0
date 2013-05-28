From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 28 May 2013 10:47:48 +0000
Subject: Re: fb_monspecs and device tree
Message-Id: <20130528104748.GL1952@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CACQ1gAg=nyZrXMKk2g+cFvn5g7kHnRKMQ9R2G7ufAqs07dkYHg@mail.gmail.com>
In-Reply-To: <CACQ1gAg=nyZrXMKk2g+cFvn5g7kHnRKMQ9R2G7ufAqs07dkYHg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>

On 11:41 Tue 28 May     , Richard Genoud wrote:
> Hi !
> 
> I've been using the display-timings device tree node (great job !) on
> a sam9x5 soc.
> 
> I was wondering if there's a planned support for struct fb_monspecs in
> device tree, (or if it is irrelevant), if someone is already working
> on that etc...

 I'm working on this but not on fbdev on DRI/KMS
 so we can have a full support of the overlay & co
 but I'm going to change complely the dt binding with the one present on
 github

 beawre the lcdc is already done on fbdev with display-timings

 but I'll be off the first week on June so wait a few for sam9x5

 Best Regards,
 J.
> 
> 
> Regards,
> Richard.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
