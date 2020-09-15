From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 15 Sep 2020 05:19:07 +0000
Subject: Re: [PATCH] docs : fb : vesafb.rst : Removed scrollback related lines
Message-Id: <20200915051907.GA12074@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200915051219.19479-1-unixbhaskar@gmail.com>
In-Reply-To: <20200915051219.19479-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org

On Tue, Sep 15, 2020 at 10:42:19AM +0530, Bhaskar Chowdhury wrote:
> This patch removed the scrollback related lines from this file : vesafb.rst
> 
> In the effect of this commit hashes : 50145474f6ef4a9c19205b173da6264a644c7489
> and 973c096f6a85e5b5f2a295126ba6928d9a6afd45

When referencing git commits, please follow the documented way of doing
this:
	50145474f6ef ("fbcon: remove soft scrollback code")

Can you fix this up and resend?

And you have a few too many ' ' in your subject :)

thanks,

greg k-h
