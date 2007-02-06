From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] fbdev driver for S3 Trio/Virge
Date: Tue, 06 Feb 2007 23:51:06 +0100
Message-ID: <45C9065A.7010102@gmail.com>
References: <20070205195130.GB5206@localhost.localdomain> <45C7B0A8.50707@gmail.com> <20070206211746.GA31501@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030196AbXBFWuu@vger.kernel.org>
In-Reply-To: <20070206211746.GA31501@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Ondrej Zajicek napsal(a):
> On Mon, Feb 05, 2007 at 11:33:12PM +0100, Jiri Slaby wrote:                                                             
>> Ondrej Zajicek napsal(a):
>>> +#ifdef CONFIG_MTRR
>>> +#include <asm/mtrr.h>
>>> +#endif
>> Why ifdef? It's ifdeffed in the header itself.
> 
> But this header is only available on some archs, isn't it?

Yup, I stand corrected.

>>> +		memset(&(par->state), 0, sizeof(struct vgastate));
>>> +		par->state.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS | 
>>> VGA_SAVE_CMAP;
>>> +		par->state.num_crtc = 0x70;
>>> +		par->state.num_seq = 0x20;
>>> +		save_vga(&(par->state));
>>> +	}
>>> +
>>> +	atomic_inc(&(par->ref_count));
>>> +
>>> +	return 0;
>>> +}
> 
> This pattern is in several fbdev drivers (neofb, i810fb, rivafb, vga16fb).
> I understand the problem but i am not sure what is the best solution.

Blah. It should be fixed, then.

> Maybe acquire/release console semaphore before/after s3fb_open?

Kick atomic_t-s off and use mutexes to protect simple uint or something like this.

>>> +static int s3fb_release(struct fb_info *info, int user)
>>> +{
>>> +	struct s3fb_info *par = (struct s3fb_info *) info;
>> Use container_of for this (and below/above).
> 
> Isn't container_of overkill for this case?

Hmm, maybe yes. Anyway it's not so clean way to do it.

I can see, they have void *par in fb_info. I would do:
struct s3fb_info {
	int chip, rev, mclk_freq;
	int mtrr_reg;
	struct vgastate state;
	atomic_t ref_count;
	u32 pseudo_palette[16];
};
I.e. no struct fb_info inside, since you allocate the space twice by 
framebuffer_alloc() -- 2*sizeof(struct fb_info) + sizeof(struct s3fb_info) + 
padding.
Then normally
framebuffer_alloc(sizeof(struct s3fb_info), NULL);
and happily use
struct s3fb_info *s = info->par;
since par member is set directly to aligned space after fb_info when size is 
nonzero inside the framebuffer_alloc().

Is there any problem with this approach?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
