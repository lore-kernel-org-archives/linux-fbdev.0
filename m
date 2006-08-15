From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4] sisusbvga: fix sisusb.c
Date: Tue, 15 Aug 2006 08:09:11 +0800
Message-ID: <1155600551.3917.25.camel@daplas.org>
References: <6cb5f1c10608131347s69e2c1adgf0a72041314d6bf0@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GCmUi-00080Y-Va for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 17:09:21 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GCmUi-0007S7-Ap
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 17:09:20 -0700
Received: by py-out-1112.google.com with SMTP id c31so1607528pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 14 Aug 2006 17:09:18 -0700 (PDT)
In-Reply-To: <6cb5f1c10608131347s69e2c1adgf0a72041314d6bf0@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org, thomas@winischhofer.net, linux-usb-devel@lists.sourceforge.net

On Mon, 2006-08-14 at 05:47 +0900, Mitsuhiro KOGA wrote:

Added the author to the CC list.

It would be better if you remove the #ifdef within the functions.
So something like...

> I had a problem with usb2vga and ppc linux.
> The background of the console greens, and the font is not displayed.
> 
> This patch can be normally displayed by the Big endian machine.
> Moreover, because KAIREN's usb2vga has two or more devices id, it adds it.
> 
> Signed-off-by: Mitsuhiro Koga <shiena.jp@gmail.com>
> Cc: linux-usb-devel@lists.sourceforge.net
> Cc: linux-fbdev-devel@lists.sourceforge.net
> ---
>  drivers/usb/misc/sisusbvga/sisusb.c      |   27 ++++++++++++++++++++++++++-
>  1 files changed, 26 insertions(+), 1 deletions(-)
> --- a/drivers/usb/misc/sisusbvga/sisusb.c
> +++ b/drivers/usb/misc/sisusbvga/sisusb.c
> @@ -76,6 +76,16 @@
> 
>  DEFINE_MUTEX(disconnect_mutex);
> 
> +#ifdef __BIG_ENDIAN
> +static void
> +correct_endianness_buffer(u16* data, const int length)
> +{
> +   int i;
> +   for (i = 0; i < length; i++)
> +       *(data+i) = cpu_to_le16(*(data+i));
> +}
> +#endif
> +
>  static void
>  sisusb_free_buffers(struct sisusb_usb_data *sisusb)
>  {
> @@ -411,6 +421,10 @@
>             memcpy(buffer, kernbuffer, passsize);
>             kernbuffer += passsize;
> 
> +#ifdef __BIG_ENDIAN
> +           if ((len & 3) == 0)
> +               correct_endianness_buffer((u16 *)buffer, thispass/2);
> +#endif
>         }
> 

#ifdef __LITTLE_ENDIAN
static inline void sisusb_memcpy(void *d, void *s, int count)
{
	memcpy(d, s, count);
}
#else
static inline void sisusb_memcpy(void *d, void *s, int count)
{
	memcpy_and_reverse(d, s, count);
}
#endif

>         retry = 5;
> @@ -906,9 +920,13 @@
>             if (userbuffer) {
>                 if (get_user(swap32, (u32 __user *)userbuffer))
>                     return -EFAULT;
> -           } else
> +           } else {
>                 swap32 = *((u32 *)kernbuffer);
> 
> +#ifdef __BIG_ENDIAN
> +               swap32 = ((swap32 << 16) & 0xffff0000) | ((swap32 >>
> 16) & 0xffff);
> +#endif
> +           }
>             ret = sisusb_write_memio_long(sisusb,
>                             SISUSB_TYPE_MEM,
>                             addr,
> @@ -1259,7 +1277,11 @@
> 
>                     userbuffer += 4;
>                 } else {
> +#ifdef __BIG_ENDIAN
> +                   *((u32 *)kernbuffer) = ((swap32 << 16) &
> 0xffff0000) | ((swap32 >> 16) & 0xffff);
> +#else
>                     *((u32 *)kernbuffer) = swap32;
> +#endif
>                     kernbuffer += 4;
>                 }

And for the above 2, something like...

#ifdef __BIG_ENDIAN
static inline void sisusb_reverse(u32 *s, u32 *d)
{
	*d = ((*s << 16) & 0xffff0000) | ((*s >> 16) & 0xffff);
}
#else
static inline void sisiusb_reverse(u32 *s, u32 *d)
{
	*d = *s;
}
#endif

Tony
>                 addr += 4;
> @@ -3435,6 +3457,9 @@
> 
>  static struct usb_device_id sisusb_table [] = {
>     { USB_DEVICE(0x0711, 0x0900) },
> +   { USB_DEVICE(0x0711, 0x0901) },
> +   { USB_DEVICE(0x0711, 0x0902) },
> +   { USB_DEVICE(0x0711, 0x0920) },
>     { USB_DEVICE(0x182d, 0x021c) },
>     { USB_DEVICE(0x182d, 0x0269) },
>     { }
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
