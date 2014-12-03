From: David Ung <davidu@nvidia.com>
Date: Wed, 03 Dec 2014 20:51:02 +0000
Subject: RE: [PATCH] video: fbmon: Check Standard Timing against DMT and maxclk
Message-Id: <6680eb7c6c20472cb6246ebe7aaf0c1c@HQMAIL102.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416626512-12919-1-git-send-email-davidu@nvidia.com>
In-Reply-To: <1416626512-12919-1-git-send-email-davidu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

> 
> Sorry I haven't been able to check this yet. I had a brief glance, and I wonder
> if the patch should be split. You add modes to vesa_modes, I presume those
> modes are valid even without any DMT or maxclk changes?
> 
> Also the maxclk check sounds like an independent change.
> 

I'll split the patch up and resubmit.
David

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
