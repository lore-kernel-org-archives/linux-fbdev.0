From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 15 Sep 2020 06:04:37 +0000
Subject: Re: [PATCH v2] docs: fb: Remove scrollback related lines
Message-Id: <20200915060437.GA16383@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200915055712.968-1-unixbhaskar@gmail.com>
In-Reply-To: <20200915055712.968-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org

On Tue, Sep 15, 2020 at 11:27:12AM +0530, Bhaskar Chowdhury wrote:
> This patch removed the framebuffer scrollback related lines.
> 
> This is the effect of this commmit  50145474f6ef ("fbcon: remove soft scrollback code")

Why the extra ' '?

And you can line-wrap things here :)

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
> Following Greg's suggestions,fix the subject line and include the commit Subject

Same thing for all of your patches you sent...

thanks,

greg k-h
