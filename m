From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][FBDEV] Fix copy_to/from_user in
 fbmem.c:fb_read/write
Date: Mon, 30 Aug 2004 02:15:44 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040830021544.2ca107f5.akpm@osdl.org>
References: <200408301047.28117.adaplas@hotpop.com>
	<Pine.GSO.4.58.0408301107430.3353@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1iIG-0003B5-L9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 02:17:40 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C1iIF-0003LY-Uz
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 02:17:40 -0700
In-Reply-To: <Pine.GSO.4.58.0408301107430.3353@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, davem@redhat.com

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > +
>  > +	cnt = 0;
>  > +	buffer = kmalloc((count > 64 * 1024) ? 64 * 1024 : count,
>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  > +			 GFP_KERNEL);
>  > +	if (!buffer)
>  > +		return -ENOMEM;
> 
>  Woops, what's the probability of a 64 kiB kmalloc() to fail?

Relatively high.

>      [...]
> 
>  > +	while (count) {
>  > +		c  = (count > 64 * 1024) ? 64 * 1024 : count;
>  > +		dst = buffer;
>  > +		for (i = c >> 2; i--; )
>  > +			*dst++ = fb_readl(src++);
>  > +		if (c & 3) {
>  > +			for (i = c & 3; i--;)
>  > +				*((u8 *)dst++) = fb_readb((u8 *) src++);
>  > +		}
>  > +
>  > +		if (copy_to_user(buf, buffer, c)) {
>  > +			err = -EFAULT;
>  > +			break;
>  > +		}
>  > +		*ppos += c;
>  > +		buf += c;
>  > +		cnt += c;
>  > +		count -= c;
>  >  	}
> 
>  I don't expect the penalty for always using a buffer of PAGE_SIZE to be very
>  large. Or am I missing something?

The 64k copy buffer will most likely be slower than using an 8k one.  it
depends, of course, upon the vintage of the CPU.

4k or 8k should be fine here.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
