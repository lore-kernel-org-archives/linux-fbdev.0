From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 26 Nov 2018 08:14:32 +0000
Subject: Re: [PATCH] Fonts: New Terminus large console font
Message-Id: <20181126081432.GA30722@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181126034734.9423-1-amanoeladawod@gmail.com>
 <20181126065646.GA9680@kroah.com>
 <CACd_pd8o5vA85ppNp3hzm+awBvwq6VEONij6rHAPExmPfjaWRA@mail.gmail.com>
In-Reply-To: <CACd_pd8o5vA85ppNp3hzm+awBvwq6VEONij6rHAPExmPfjaWRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Amanoel Dawod <amanoel@amanoeldawod.com>
Cc: akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Mon, Nov 26, 2018 at 03:09:31AM -0500, Amanoel Dawod wrote:
> Changing the name did not break anything. Pretty much I dumped the original
> .psf file to .inc
> format with new naming using psftools extracting the bitmap data. Then
> manually editing it
> removing useless header, leaving bitmaps data alone.

I did not refer to any name, just the #define that you changed.

> Do you mean adding it at end of lists with other fonts? if that's what you
> mean,
> no real reason, but just wanted it to be after sun12x22 always as in
> Kconfig.

You can put it wherever you want in the Kconfig file (but you should put
it at the end, as it is a new font.)  I mean the #defines, you need to
just add it at the end please, do not change any existing #defines.


> Please let me know if that must be changed.
> Now regarding "From:" line, please accept my apology as it my first time
> dealing
> with submissions and git send-mail. Should I re-submit the patch with
> modified subject line?

Not subject line, From: line from your email client.  And you need to
change the patch anyway before it could be added, so you have to resend
it :)

thanks,

greg k-h
