From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 12 Mar 2017 04:46:38 +0000
Subject: Re: [PATCH] staging: sm750fb: Improved coding style
Message-Id: <20170312044638.GB13797@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170312023402.GA10352@arushi-HP-Pavilion-Notebook>
In-Reply-To: <20170312023402.GA10352@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: sudipm.mukherjee@gmail.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com

On Sun, Mar 12, 2017 at 08:04:02AM +0530, Arushi Singhal wrote:
> New variables are added to make the code more readable.
> Also fixed the checkpatch issue: "Alignment should match open
> parenthesis".

When you have to say "also" in a commit message, that is a huge red-flag
that you need to break a patch up into different parts, as you are doing
multiple things.  Please do so here.

thanks,

greg k-h
