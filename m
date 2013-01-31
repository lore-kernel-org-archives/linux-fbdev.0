From: Alexandre Courbot <gnurou@gmail.com>
Date: Thu, 31 Jan 2013 06:36:57 +0000
Subject: Re: [RFC 1/4] video: panel: add CLAA101WA01A panel support
Message-Id: <CAAVeFuL_a1aAEDCFdhjMzZG40QuK3dcZqsWqfVpwmQbZsfiHRg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com>
 <1359514939-15653-2-git-send-email-acourbot@nvidia.com> <5108C9C1.1090707@gmail.com>
 <51098064.7030902@wwwdotorg.org> <5109EA2A.8020204@gmail.com>
 <CAAVeFuJf9Ww7g8Q9RAG9Na1SZq2-n2MMxcAEBek52ZVG7RpL7g@mail.gmail.com> <5109F916.8080404@gmail.com>
In-Reply-To: <5109F916.8080404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Zhang <nvmarkzhang@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thierry Reding <thierry.reding@avionic-design.de>, Mark Zhang <markz@nvidia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "acourbot@nvidia.com" <acourbot@nvidia.com>

On Thu, Jan 31, 2013 at 1:54 PM, Mark Zhang <nvmarkzhang@gmail.com> wrote:
> Display controller don't know whether the panel has EDID EEPROM but the
> panel driver knows. So why we need to make display controller queries
> EDID blindly? Since panel driver knows about all "video modes/panel
> size" stuffs, why not we let it handle all these things?

The DC actually does know whether the connected panel supports EDID -
in this case, the output node will have a property for the DDC bus,
e.g.

        nvidia,ddc-i2c-bus = <&lcd_ddc>;

If no DDC bus is specified or if transfer fails, the DC driver can
still query the panel driver for hardcoded modes.

Also passing a function pointer to get_modes() does not relief the DC
driver from probing for the DDC bus. You will still have to handle
both conditions (DDC bus present or not), the check will just be moved
into your callback function.

Alex.
