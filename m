From: David Ung <davidu@nvidia.com>
Date: Wed, 14 Jan 2015 05:24:09 +0000
Subject: RE: [patch] fbdev: off by one test (harmless)
Message-Id: <b3048cbf401f4591a32a76358fcd8156@HQMAIL102.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20141226172657.GA14762@mwanda>
In-Reply-To: <20141226172657.GA14762@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@ti.com]
> Sent: Tuesday, January 13, 2015 3:19 AM
> To: David Ung; 'Jingoo Han'; 'Dan Carpenter'
> Cc: 'Jean-Christophe Plagniol-Villard'; 'Daniel Vetter'; 'Laurent Pinchart';
> 'Rob Clark'; linux-fbdev@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: Re: [patch] fbdev: off by one test (harmless)
> 
> * PGP Signed by an unknown key
> 
> On 29/12/14 23:51, David Ung wrote:
> >
> >>> test is really a no-op.  But it's still off by one and upsets the
> >>> static checkers so we may as well correct it.
> >>
> >> 'idx' should be 0~63, because cea_modes array is defined as
> >> 'cea_modes[64]'.
> >
> > According to CEA/EIA-861E, there are 64 defined modes, but idx is
> > valid for 1-64, 0 is reserved hence the check for
> >
> >         If (!idx || idx > 63) {
> >
> > Think idx check really should be !idx || idx > 64 if following
> > CEA/EIA-861E
> 
> In that case there's something funny with the code. The code indexes
> 'cea_modes' using 'idx', and I _think_ cea_modes is already offset properly,
> i.e. there's no entry at 0. But its length is 64, which is not right, as there's the
> empty item in the beginning.
> 
> So maybe the correct fix is to increase the length of cea_modes to 65, and
> change the idx check as you mention above?
> 

In that case might aswell go with CEA/EAI-861F for completeness and have the check against 107.
but with a slight waste of memory.

David
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
