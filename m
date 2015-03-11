From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 11 Mar 2015 08:56:04 +0000
Subject: Re: [PATCH 4/6] staging: sm750fb: Expose hw712_fillrect externally
Message-Id: <20150311085604.GV10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
 <1426037325-8392-4-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426037325-8392-4-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 01:28:43AM +0000, Lorenzo Stoakes wrote:
> This patch adds a reference to hw712_fillrect which is not used elsewhere in the driver,
> but appears to be an alternative to the hw_fillrect method. This patch fixes the following sparse warning:-
> 
> drivers/staging/sm750fb/sm750_accel.c:95:5: warning: symbol 'hw712_fillrect' was not declared. Should it be static?
> 

Just delete it.

regards,
dan carpenter

