From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] intelfb: support 945GME (as used in
 ASUS Eee 901)
Date: Sun, 31 Aug 2008 09:27:22 +0200
Message-ID: <20080831092722.c80c73c5.krzysztof.h1@poczta.fm>
References: <1220010645384@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZhEx-00064u-UX for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 Aug 2008 00:20:52 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KZhEw-00046w-DZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 Aug 2008 00:20:51 -0700
In-Reply-To: <1220010645384@dmwebmail.dmwebmail.chezphil.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Phil Endecott <phil_utscv_endecott@chezphil.org>
Cc: sylvain.meyer@worldonline.fr, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 29 Aug 2008 12:50:45 +0100
"Phil Endecott" <phil_utscv_endecott@chezphil.org> wrote:

> The following patch adds support for Intel's 945GME graphics chip to
> the intelfb driver.  I have assumed that the 945GME is identical to the
> already-supported 945GM apart from its PCI IDs; this is based on a quick
> look at the X driver for these chips which seems to treat them
> identically.
> 
> Signed-off-by: Phil Endecott <spam_from_intelfb@chezphil.org>
> 
> ---
> 
> The 945GME is used in the ASUS Eee 901, and I coded this in the hope that 
> I'd be able to use it to get a console at the native 1024x600 resolution 
> which is not known to the BIOS.  I realised too late that the intelfb 
> driver does not support mode changing on laptops, so it won't be any 
> use for me.  But rather than throw it away I will post it here as 
> essentially "untested"; maybe someone who knows more about this driver, 
> and with more useful hardware to test on, can pick it up.
> 
> diff --git a/Documentation/fb/intelfb.txt b/Documentation/fb/intelfb.txt
> index 27a3160..dd9e944 100644
> --- a/Documentation/fb/intelfb.txt
> +++ b/Documentation/fb/intelfb.txt
> @@ -14,6 +14,7 @@ graphics devices.  These would include:
>  	Intel 915GM
>  	Intel 945G
>  	Intel 945GM
> +	Intel 945GME
>  	Intel 965G
>  	Intel 965GM
>  
> diff --git a/drivers/video/intelfb/intelfb.h b/drivers/video/intelfb/intelfb.h
> index 3325fbd..a50bea6 100644
> --- a/drivers/video/intelfb/intelfb.h
> +++ b/drivers/video/intelfb/intelfb.h
> @@ -12,9 +12,9 @@
>  #endif
>  
>  /*** Version/name ***/
> -#define INTELFB_VERSION			"0.9.5"
> +#define INTELFB_VERSION			"0.9.6"
>  #define INTELFB_MODULE_NAME		"intelfb"
> -#define SUPPORTED_CHIPSETS		"830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM"
> +#define SUPPORTED_CHIPSETS		"830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/945GME/965G/965GM"
>  

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

BTW, Is it possible to shorten this list by something like "830/845/852/865/915/945/965 models G, GM and GME" or 
"830M/8x5G/8x5GM/9x5G/9x5GM/9x5GME" or maybe something else?

Regards,
Krzysztof


----------------------------------------------------------------------
>> Sprawdz, czy do siebie pasujecie!
>> http://link.interia.pl/f1eea


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
