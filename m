From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 17 Sep 2020 07:47:47 +0000
Subject: Re: [PATCH v3] docs: fb: Remove framebuffer scrollback boot option
Message-Id: <20200917074747.GA3332340@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200916230150.14516-1-unixbhaskar@gmail.com>
In-Reply-To: <20200916230150.14516-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net, torvalds@linux-foundation.org

On Thu, Sep 17, 2020 at 04:31:50AM +0530, Bhaskar Chowdhury wrote:
> This patch remove reference to this option in this document and 
> renumbered the sections. This is related to below commits.
> 
> Commit 973c096f6a85(vgacon: remove software scrollback support)
> Commit 50145474f6ef(fbcon: remove soft scrollback code)
>  
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
> This version try to correct the previous errors, proper changelog text, subject
> Trying to incorporate Willy's & Greg's suggestions

Better, but...

This should be a patch series, properly numbered and threaded, right?

The text above still has the commit ids not properly referenced, and you
have trailing whitespace in the text too.

Writing the changelog is often times the hardest part of a patch, as you
are finding out.

How about this example, for this specific patch, as a changelog text:

---------
In commit 50145474f6ef ("fbcon: remove soft scrollback code"), the
framebuffer scrollback mode was removed, but the documentation was not
updated.  Properly update the documentation by removing the option that
is no longer present, and update the section numbering because of the
removal.
---------

Doesn't that make more sense about what is happening here, and provide
enough information that when someone 10+ years from now goes and tries
to find out why a boot option went away, what exactly happened and why?

Can you make this type of change to all 4 of these patches and resend
them, with the proper change information below the --- line as a v4
series?

thanks,

greg k-h
