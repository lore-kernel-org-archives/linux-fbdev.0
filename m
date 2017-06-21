From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 21 Jun 2017 14:35:08 +0000
Subject: Re: [PATCH] staging: sm750fb: move common locking code to a macro
Message-Id: <20170621143508.GB14790@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170620165013.11013-1-mail@dbalan.in>
In-Reply-To: <20170620165013.11013-1-mail@dbalan.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dhananjay Balan <mail@dbalan.in>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Tue, Jun 20, 2017 at 06:50:13PM +0200, Dhananjay Balan wrote:
> The locking and unlocking code used by copy routines is common, so
> moved it to a macro.

Ick, no, never "hide" locks like this, that's not good at all.  We want
to see the locks in the code where it happens, otherwise it is not
obvious as to what is going on.

sorry,

greg k-h
