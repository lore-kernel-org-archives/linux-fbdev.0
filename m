From: "Mitsuhiro KOGA" <shiena.jp@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4] sisusbvga: fix sisusb.c
Date: Thu, 17 Aug 2006 00:33:26 +0900
Message-ID: <6cb5f1c10608160833w4aba9f94va5b011fe49a7aef2@mail.gmail.com>
References: <6cb5f1c10608131347s69e2c1adgf0a72041314d6bf0@mail.gmail.com>
	<1155600551.3917.25.camel@daplas.org>
	<6cb5f1c10608160431w1b294780yee3404a779da38ff@mail.gmail.com>
	<1155733001.15309.13.camel@daplas.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GDNOc-0004Lm-RP for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Aug 2006 08:33:31 -0700
Received: from nf-out-0910.google.com ([64.233.182.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GDNOa-0001oz-UQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Aug 2006 08:33:30 -0700
Received: by nf-out-0910.google.com with SMTP id l36so632604nfa
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 Aug 2006 08:33:26 -0700 (PDT)
In-Reply-To: <1155733001.15309.13.camel@daplas.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: akpm@osdl.org, thomas@winischhofer.net, linux-fbdev-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net

2006/8/16, Antonino A. Daplas <adaplas@gmail.com>:
> On Wed, 2006-08-16 at 20:31 +0900, Mitsuhiro KOGA wrote:
> > Hi,
> >
>
> >  static void
> >  sisusb_free_buffers(struct sisusb_usb_data *sisusb)
> >  {
> > @@ -408,7 +465,11 @@ static int sisusb_send_bulk_msg(struct s
> >
> >               } else if (fromkern) {
> >
> > -                     memcpy(buffer, kernbuffer, passsize);
> > +                     if ((len & 3) == 0)
> > +                             sisusb_memcpy((u16 *)buffer, (u16 *)kernbuffer, passsize / 2);
> > +                     else
> > +                             memcpy(buffer, kernbuffer, passsize);
>
> What happens if (len & 3) != 0? It ends up doing a regular memcpy()
> without the reordering.  Better if you move the if (len & 3) == 0 check
> to sisusb_memcpy(), so instead of
>
>                        if ((len & 3) == 0)
>                                sisusb_memcpy((u16 *)buffer, (u16 )kernbuffer, passsize / 2);
>                        else
>                                memcpy(buffer, kernbuffer, passsize);
>

(a) if (len & 3) != 0
When former data length is 4 or less, struct sisusb_packet is used.
It becomes 10 in length for writing.
Because data is not used, it becomes 6 in length for reading.

struct sisusb_packet {
    unsigned short header;
    u32 address;
    u32 data;
} __attribute__((__packed__));

(b) if (len & 3) == 0
When former data length is larger than 4,
it corresponds to this case because the length of (data & ~3) is passed.
As for the data of the remainder, the logic of (a) is used.


> it simply condenses into
>
>                         sisusb_memcpy().
>
>

yes.
I also think that it is good.

> > +
> >                       kernbuffer += passsize;
> >
> >               }
> > @@ -872,25 +933,9 @@ static int sisusb_write_mem_bulk(struct
> >                       if (userbuffer) {
> >                               if (copy_from_user(&buf, userbuffer, 3))
> >                                       return -EFAULT;
> > -#ifdef __BIG_ENDIAN
> > -                             swap32 = (buf[0] << 16) |
> > -                                      (buf[1] <<  8) |
> > -                                      buf[2];
> > -#else
> > -                             swap32 = (buf[2] << 16) |
> > -                                      (buf[1] <<  8) |
> > -                                      buf[0];
> > -#endif
> > +                             sisusb_order_wmem_24bit(&buf, &swap32);
> >                       } else
> > -#ifdef __BIG_ENDIAN
> > -                             swap32 = (kernbuffer[0] << 16) |
> > -                                      (kernbuffer[1] <<  8) |
> > -                                      kernbuffer[2];
> > -#else
> > -                             swap32 = (kernbuffer[2] << 16) |
> > -                                      (kernbuffer[1] <<  8) |
> > -                                      kernbuffer[0];
> > -#endif
> > +                             sisusb_order_wmem_24bit(kernbuffer, &swap32);
> >
> >                       ret = sisusb_write_memio_24bit(sisusb,
> >                                                       SISUSB_TYPE_MEM,
> > @@ -907,7 +952,7 @@ static int sisusb_write_mem_bulk(struct
> >                               if (get_user(swap32, (u32 __user *)userbuffer))
> >                                       return -EFAULT;
> >                       } else
> > -                             swap32 = *((u32 *)kernbuffer);
> > +                             sisusb_order_mem_32bit((u32 *)kernbuffer, &swap32);
> >
> >                       ret = sisusb_write_memio_long(sisusb,
> >                                                       SISUSB_TYPE_MEM,
> > @@ -1227,15 +1272,7 @@ static int sisusb_read_mem_bulk(struct s
> >                                                               addr, &swap32);
> >                       if (!ret) {
> >                               (*bytes_read) += 3;
> > -#ifdef __BIG_ENDIAN
> > -                             buf[0] = (swap32 >> 16) & 0xff;
> > -                             buf[1] = (swap32 >> 8) & 0xff;
> > -                             buf[2] = swap32 & 0xff;
> > -#else
> > -                             buf[2] = (swap32 >> 16) & 0xff;
> > -                             buf[1] = (swap32 >> 8) & 0xff;
> > -                             buf[0] = swap32 & 0xff;
> > -#endif
> > +                             sisusb_order_rmem_24bit(&swap32, &buf[0]);
> >                               if (userbuffer) {
> >                                       if (copy_to_user(userbuffer, &buf[0], 3))
> >                                               return -EFAULT;
> > @@ -1259,7 +1296,7 @@ static int sisusb_read_mem_bulk(struct s
> >
> >                                       userbuffer += 4;
> >                               } else {
> > -                                     *((u32 *)kernbuffer) = swap32;
> > +                                     sisusb_order_mem_32bit((u32 *)kernbuffer, &swap32);
> >                                       kernbuffer += 4;
> >                               }
> >                               addr += 4;
> > @@ -3435,6 +3472,9 @@ static void sisusb_disconnect(struct usb
>
> I would agree with Geert. Combine all into a single #ifdef/#else/#endif.
> Since we are still in the reviewing phase, do not submit incremental
> patches.

Thank you for your advice. I understand.


--
Mitsuhiro KOGA
<shiena.jp@gmail.com>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
