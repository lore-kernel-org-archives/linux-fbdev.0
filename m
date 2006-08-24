From: "Mitsuhiro KOGA" <shiena.jp@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4] sisusbvga: fix sisusb.c
Date: Thu, 24 Aug 2006 15:34:04 +0900
Message-ID: <6cb5f1c10608232334p65bead07v21a3035bc9f23d03@mail.gmail.com>
References: <6cb5f1c10608131347s69e2c1adgf0a72041314d6bf0@mail.gmail.com>
	<1155600551.3917.25.camel@daplas.org>
	<6cb5f1c10608160431w1b294780yee3404a779da38ff@mail.gmail.com>
	<1155733001.15309.13.camel@daplas.org>
	<6cb5f1c10608160833w4aba9f94va5b011fe49a7aef2@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GG8n1-0001qg-Vq for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Aug 2006 23:34:08 -0700
Received: from nf-out-0910.google.com ([64.233.182.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GG8n0-0001t7-TQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Aug 2006 23:34:07 -0700
Received: by nf-out-0910.google.com with SMTP id m19so529725nfc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Aug 2006 23:34:04 -0700 (PDT)
In-Reply-To: <6cb5f1c10608160833w4aba9f94va5b011fe49a7aef2@mail.gmail.com>
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

I'm sorry. Because the mistake and lack were found in the explanation,
a postscript is added to it.

2006/8/17, Mitsuhiro KOGA <shiena.jp@gmail.com>:
> 2006/8/16, Antonino A. Daplas <adaplas@gmail.com>:
> > On Wed, 2006-08-16 at 20:31 +0900, Mitsuhiro KOGA wrote:
> > > Hi,
> > >
> >
> > >  static void
> > >  sisusb_free_buffers(struct sisusb_usb_data *sisusb)
> > >  {
> > > @@ -408,7 +465,11 @@ static int sisusb_send_bulk_msg(struct s
> > >
> > >               } else if (fromkern) {
> > >
> > > -                     memcpy(buffer, kernbuffer, passsize);
> > > +                     if ((len & 3) == 0)
> > > +                             sisusb_memcpy((u16 *)buffer, (u16 *)kernbuffer, passsize / 2);
> > > +                     else
> > > +                             memcpy(buffer, kernbuffer, passsize);
> >
> > What happens if (len & 3) != 0? It ends up doing a regular memcpy()
> > without the reordering.  Better if you move the if (len & 3) == 0 check
> > to sisusb_memcpy(), so instead of
> >
> >                        if ((len & 3) == 0)
> >                                sisusb_memcpy((u16 *)buffer, (u16 )kernbuffer, passsize / 2);
> >                        else
> >                                memcpy(buffer, kernbuffer, passsize);
> >
>
> (a) if (len & 3) != 0
> When former data length is 4 or less, struct sisusb_packet is used.
> It becomes 10 in length for writing.
> Because data is not used, it becomes 6 in length for reading.
>
> struct sisusb_packet {
>     unsigned short header;
>     u32 address;
>     u32 data;
> } __attribute__((__packed__));
>
> (b) if (len & 3) == 0
> When former data length is larger than 4,
> it corresponds to this case because the length of (data & ~3) is passed.
> As for the data of the remainder, the logic of (a) is used.

The length passed here is not (data & ~3) but (former data length & ~3).

And, variable buffer becomes a character string displayed in the monitor
a couple of byte sequence by two bytes (the character-code and the delimiter).
Because this order reverses for the Big endian, variable buffer is
being replaced.

In the case of (a), sisusb_pack->data is being replaced with
cpu_to_le32 in existing processing,
and because the order of the character reverses for four bytes, data
is being replaced
with sisusb_order_mem_32 further.

Regards,

-- 
Mitsuhiro KOGA
<shiena.jp@gmail.com>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
