From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 15 Sep 2020 13:41:27 +0000
Subject: Re: [PATCH] docs: fb:  Remove scrollback option
Message-Id: <20200915134127.GA873393@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200915132736.5264-1-unixbhaskar@gmail.com>
In-Reply-To: <20200915132736.5264-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org

On Tue, Sep 15, 2020 at 06:57:36PM +0530, Bhaskar Chowdhury wrote:
> 
> This patch remove the scrollback option under boot option.
> Plus readjust the numbers for the options in that section.
> 
> This is the effect of these commits:
> 
> 973c096(vgacon: remove software scrollback support)
> 5014547(fbcon: remove soft scrollback code)

The kernel documentation file:
	https://www.kernel.org/doc/html/latest/process/submitting-patches.html
in section 2, describes how to show git ids within changelog text
properly (the number of characters and the rest.)

Can you fix this up and resend?

And this is a v2 patch, right?  Always document what changed from
previous patches below the --- line, as the above link asks for.

thanks,

greg k-h
