From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 23 May 2011 07:13:01 +0000
Subject: Re: [patch 1/2] trivial: amba-clcd.c preferred form of passing size of structure
Message-Id: <20110523071301.GK5206@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305742026.8771.26.camel@anish-desktop>
In-Reply-To: <1305742026.8771.26.camel@anish-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: anish <anish198519851985@gmail.com>
Cc: linux@arm.linux.org.uk, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 18, 2011 at 11:37:06PM +0530, anish wrote:
> The preferred form for passing a size of a struct is the following:
>          p = kmalloc(sizeof(*p), ...);
>   Please refer Documentation/Codingstyle chapter 14
> 
>  Signed-off-by: anish kumar <anish198519851985@gmail.com>
> 
That's pretty subjective, and ultimately depends on the author. I
personally prefer to have it written out, but then I don't randomly
change my structure types around either, so the "bug" alluded to isn't
really an issue. I'm not sure I buy the impaired readability argument,
either..
