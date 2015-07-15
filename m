From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2015 03:06:05 +0000
Subject: Re: [PATCH 3/5] staging: sm7xxfb: use kernel commandline
Message-Id: <20150715030605.GA26359@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1436256877-10754-4-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1436256877-10754-4-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Tue, Jul 07, 2015 at 01:44:35PM +0530, Sudip Mukherjee wrote:
> We were only using the kernel commandline to set the mode if this driver
> is builtin, but when it is built as a module we were not having any way
> to set the mode. Start using commandline even if it is built as a
> module.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

I applied the first 3 patches here, but not 4 and 5.
