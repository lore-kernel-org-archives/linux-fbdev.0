From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 09 Mar 2015 13:13:43 +0000
Subject: Re: [PATCH 3/3] staging: sm7xxfb: change return of sm7xx_vga_setup
Message-Id: <20150309131343.GG10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425836411-15481-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1425836411-15481-3-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425836411-15481-3-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Mar 08, 2015 at 11:10:11PM +0530, Sudip Mukherjee wrote:
> change return type of sm7xx_vga_setup() to void as we are not using
> the return type anywhere. if this function fails we fall back to the
> default configuration.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

This patch is fine but if you wanted you could send a follow on which
set it to SCREEN_X_RES, SCREEN_Y_RES, SCREEN_BPP if there were no
options.  Then remove the "if (smtc_scr_info.lfb_width != 0) " condition
in smtcfb_pci_probe().

regards,
dan carpenter

