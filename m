From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: Samsung P35 and S3 suspend
Date: Wed, 22 Dec 2004 03:06:01 +0100
Message-ID: <41C8D689.3020502@gmx.net>
References: <41BFC3AD.5030001@gmx.net> <1103117333.5924.3.camel@mhcln03>	 <41C07B6F.70900@gmx.net> <1103159022.5924.17.camel@mhcln03> <41C0FFF3.4010902@gmx.net> <41C19BD8.7050201@gmx.net> <41C1CFA2.20304@gmx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41C1CFA2.20304-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Content-Type: text/plain; charset="us-ascii"
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>, Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>, =?ISO-8859-1?Q?Stefan_D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

Carl-Daniel Hailfinger wrote:

> OK, I got S3 working with all kernels since 2.6.9 (well, your
> patches had to be modified slightly). Right now I'm running on the
> latest Linus -bk tree.
>
> I will now try other configurations and a full bootup.
>
> OK, it is working perfectly with the latest Linus -bk tree and
> everything configured in (SuSE .config, comparable to allmodconfig).

It turns out that (at least for 2.6.10-rc3 and later) the kernel
resumes from S3 perfectly regardless of .config as long as
- no framebuffer console is activated (kernel param video=vesa:off )
- pci-resume-2.6.10.patch and resume-finish-split-2.6.10.patch
  are applied
- suspend and resume happen with an active TEXT console (chvt 2)
- VESA registers are saved before suspend
- the radeon card is POSTed after resume
- the VESA registers are restored after that
- now you are free to change back to X if you want.

You do NOT need
- a patched X server
- a special kernel .config
- sacrifices of any kind.

See my other mail to acpi-devel for details about how to save/restore
the VESA registers and POST the card.

Question for the framebuffer experts: Is it possible to forbid access
to the video card after resume until the card has been POSTed and all
registers are restored? Any access to the card before that will freeze
the machine.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
