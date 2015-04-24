From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2015 08:22:30 +0000
Subject: Re: [PATCH] staging: sm750fb: cleanup white space and indent
Message-Id: <20150424082230.GA7692@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429823048-9094-1-git-send-email-charles.rose.linux@gmail.com>
In-Reply-To: <1429823048-9094-1-git-send-email-charles.rose.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Charles Rose <charles.rose.linux@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Thu, Apr 23, 2015 at 05:04:08PM -0400, Charles Rose wrote:
> This patch fixes "space prohibited" errors reported by checkpatch.pl
> and related indentation. The module builds without error.

That's two different things, can you break this up into one "logical"
patch per thing you are changing here?

thanks,

greg k-h
