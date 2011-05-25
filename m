From: Matthew Garrett <mjg@redhat.com>
Date: Wed, 25 May 2011 18:32:43 +0000
Subject: Re: efifb not detected on Intel DQ67SW
Message-Id: <20110525183243.GA28887@srcf.ucam.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTikxX577VKmPRVGcp_Chj-udCf-KaQ@mail.gmail.com>
In-Reply-To: <BANLkTikxX577VKmPRVGcp_Chj-udCf-KaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, May 25, 2011 at 02:21:17PM -0400, Andrew Lutomirski wrote:

> Looking at the code, I'm a little confused how it's supposed to work.
> AFAICT, unless there's a DMI match, then the driver will only load
> ifthe boot code sets VIDEO_TYPE_EFI, but nothing sets that.

grub should be setting that.

> Should there be something that looks at
> EFI_GRAPHICS_OUTPUT_PROTOCOL_MODE to find the frame buffer?  (Does
> that not work on Apple machines?)

By the time we get into the kernel we've called ExitBootServices(), so 
at that point we can't do anything with GOP. grub should have grabbed 
that information and stashed it in the appropriate field.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
