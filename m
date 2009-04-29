From: Jakob Bornecrantz <jakob@vmware.com>
Subject: Re: Intel KMS + fbcon + Mplayer
Date: Wed, 29 Apr 2009 15:15:23 +0200
Message-ID: <CCB52791-FFE9-487A-97E8-C902622CC162@vmware.com>
References: <7D4BD025A2554467AD77428C455E1FE0@avitech.sk>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.sourceforge.net>
In-Reply-To: <7D4BD025A2554467AD77428C455E1FE0@avitech.sk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dri-devel>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: dri-devel-bounces@lists.sourceforge.net
To: Peter Hanzel <hanzelpeter@gmail.com>
Cc: "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 29 apr 2009, at 12.04, Peter Hanzel wrote:
> Hello.
>
> I have tried Intel KMS in kernel 2.6.91.1 with fbcon. I am using only
> framebuffer console.
> Most fb apps works, but I have problem with mplayer.
> The init works but the video is badly displayed.
> I have investigated the problem and found, that for my laptop mode
> 1280x800-32.
>
> The ioctl on /dev/fb0 FBIOGET_VSCREENINFO returns.
> var.bits_per_pixel=32
> var.transp.length = 0.
>
> So the mplayer thinks we are in 24 bit mode (maybe this is bug in  
> mplayer,
> because bits_per_pixel is 32).
>
> But next I have checked it with kernel vesafb and for same mode
> (1280x800-32, vga=0x362 )
> The fb ioctl returns
> var.bits_per_pixel=32
> var.transp.length = 8.
>
> So is this intentionally made so. Because I think this mode use only  
> red,
> green,blue and no transp. But for one pixel you must write 4 bytes.  
> (so
> transp is not used).

Hmm, if I remember correctly from running mplayer in the early days of  
kms mplayer has two fbdev drivers and I think that only #2 worked. It  
did worked back then but it was a long time ago. Heck it was one of  
the first things we demoed kms with.

Cheers Jakob.

------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
--
