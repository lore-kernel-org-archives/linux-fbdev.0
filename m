From: David Ung <davidu@nvidia.com>
Date: Mon, 29 Dec 2014 21:51:23 +0000
Subject: RE: [patch] fbdev: off by one test (harmless)
Message-Id: <410219d77f8c4d0982cc9e99d0364acb@DRHQMAIL102.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20141226172657.GA14762@mwanda>
In-Reply-To: <20141226172657.GA14762@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> > test is really a no-op.  But it's still off by one and upsets the
> > static checkers so we may as well correct it.
> 
> 'idx' should be 0~63, because cea_modes array is defined as
> 'cea_modes[64]'.

According to CEA/EIA-861E, there are 64 defined modes, but idx is valid for 1-64, 0 is reserved hence the check for 

        If (!idx || idx > 63) {

Think idx check really should be !idx || idx > 64 if following CEA/EIA-861E

CEA/EIA-861F add additional entries and idx is valid from 1-107

David
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
