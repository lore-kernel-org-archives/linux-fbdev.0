From: "Mitsuhiro KOGA" <shiena.jp@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 2.6.18-rc4]
	sisusbvga: fix sisusb.c
Date: Wed, 16 Aug 2006 21:06:05 +0900
Message-ID: <6cb5f1c10608160506n4104f5aaga7442ee2c2ed5d7d@mail.gmail.com>
References: <6cb5f1c10608131347s69e2c1adgf0a72041314d6bf0@mail.gmail.com>
	<1155600551.3917.25.camel@daplas.org>
	<6cb5f1c10608160431w1b294780yee3404a779da38ff@mail.gmail.com>
	<Pine.LNX.4.62.0608161340490.4583@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.62.0608161340490.4583@pademelon.sonytel.be>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>, 
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>, 
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, thomas@winischhofer.net, linux-usb-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

2006/8/16, Geert Uytterhoeven <geert@linux-m68k.org>:
> On Wed, 16 Aug 2006, Mitsuhiro KOGA wrote:
> > @@ -76,6 +76,63 @@ static struct usb_driver sisusb_driver;
> >
> >  DEFINE_MUTEX(disconnect_mutex);
> >
> > +#ifdef __BIG_ENDIAN
> > +static inline void sisusb_memcpy(u16 *dst, u16 *src, int count)
> > +{
> > +     while (count--)
> > +             *(dst++) = cpu_to_le16(*(src++));
> > +}
> > +#else
> > +static inline void sisusb_memcpy(u16 *dst, u16 *src, int count)
> > +{
> > +     memcpy(dst, src, count);
> > +}
> > +#endif
> > +
> > +#ifdef __BIG_ENDIAN
> > +static inline void sisusb_order_wmem_24bit(char *src, u32 *dst)
> > +{
> > +     *dst = (*src        << 16) |
> > +             (*(src + 1) <<  8) |
> > +             *(src + 2);
> > +}
> > +#else
> > +static inline void sisusb_order_wmem_24bit(char *src, u32 *dst)
> > +{
> > +     *dst = (*(src + 2)  << 16) |
> > +             (*(src + 1) <<  8) |
> > +             *src;
> > +}
> > +#endif
> > +
> > +#ifdef __BIG_ENDIAN
> > +static inline void sisusb_order_rmem_24bit(u32 *src, char *dst)
> > +{
> > +     *dst       = (*src >> 16) & 0xff;
> > +     *(dst + 1) = (*src >> 8)  & 0xff;
> > +     *(dst + 2) = *src         & 0xff;
> > +}
> > +#else
> > +static inline void sisusb_order_rmem_24bit(u32 *src, char *dst)
> > +{
> > +     *(dst + 2) = (*src >> 16) & 0xff;
> > +     *(dst + 1) = (*src >> 8)  & 0xff;
> > +     *dst       = *src         & 0xff;
> > +}
> > +#endif
> > +
> > +#ifdef __BIG_ENDIAN
> > +static inline void sisusb_order_mem_32bit(u32 *src, u32 *dst)
> > +{
> > +     *dst = ((*src << 16) & 0xffff0000) | ((*src >> 16) & 0xffff);
> > +}
> > +#else
> > +static inline void sisusb_order_mem_32bit(u32 *src, u32 *dst)
> > +{
> > +     *dst = *src;
> > +}
> > +#endif
> > +
> >  static void
> >  sisusb_free_buffers(struct sisusb_usb_data *sisusb)
> >  {
>
> Why not merge the #ifdefs, so you need only one?
>

I think it is because legibly two functions of the same name queues up.
Of course, both are not cared about either.

--
Mitsuhiro KOGA
<shiena.jp@gmail.com>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
