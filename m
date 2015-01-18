From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 18 Jan 2015 00:09:14 +0000
Subject: Re: [PATCH 1/3] Revert "staging: sm7xxfb: remove driver"
Message-Id: <20150118000914.GA26160@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420028805-30488-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1420028805-30488-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudip@vectorindia.org>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org

On Wed, Dec 31, 2014 at 05:56:43PM +0530, Sudip Mukherjee wrote:
> This reverts commit "dc93c85235efa5201e9a3c116bc3fbd1afc1a182"
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
> 
> Hi Greg K-H
> With reference to our discussion at https://lkml.org/lkml/2014/11/22/54 ,
> now I have the hardware and I will be working on the code along with
> Teddy Wang.

I'm not going to accept this revert until I see some cleanup / fix
patches as well, so please make a larger series with the revert and then
some work done to the driver, so I at least have a hint it's not
abandonded.

thanks,

greg k-h
