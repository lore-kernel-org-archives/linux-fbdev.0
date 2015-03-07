From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 07 Mar 2015 00:38:34 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: add sm750 to staging
Message-Id: <20150307003834.GA2577@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425379867-2176-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1425379867-2176-2-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425379867-2176-2-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org

On Tue, Mar 03, 2015 at 04:21:06PM +0530, Sudip Mukherjee wrote:
> sm750 of Silicon Motion is pci-e display controller device and has
> features like dual display and 2D acceleration. This patch adds the
> driver to staging.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
> 
> this patch has lots of checkpatch warnings including some trailing whitespaces.

And it has build warnings as well.  Please send me patches to fix that
up as soon as possible, you will start to get nasty emails from the
0-day build bot about them...
