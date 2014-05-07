From: Belisko Marek <marek.belisko@gmail.com>
Date: Wed, 07 May 2014 05:35:26 +0000
Subject: Re: [PATCH v2 0/3] Add display support for gta04 device
Message-Id: <CAAfyv34a3FfKUzwz7UDt-77V692eLdJL+h4c0pve2V+g351Weg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398284120-4986-1-git-send-email-marek@goldelico.com>
In-Reply-To: <1398284120-4986-1-git-send-email-marek@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Tomi,

any objections to this patch set? If not can you please take it? Thanks.

On Wed, Apr 23, 2014 at 10:15 PM, Marek Belisko <marek@goldelico.com> wrote:
> This 3 patches adding display support for openmoko gta04 device.
> First patch add DT bindings for topolly td028 panel. Second add description for
> dss + panel and third fix panel probing when panel is compiled as module.
>
> Changes from v1:
> - extend panel compatible string by 'omapdss'
> - add tpo-td028 panel to dss_compat_conv_list
> - add MODULE_ALIAS macro to properly probe panel when is compiled as module
>
> Marek Belisko (3):
>   omapdss: panel-tpo-td028ec1: Add DT support.
>   ARM: dts: oma3-gta04: Add display support
>   omapdss: panel-tpo-td028ec1: Add module alias
>
>  .../bindings/video/toppoly,td028ttec1.txt          | 30 ++++++++
>  arch/arm/boot/dts/omap3-gta04.dts                  | 86 ++++++++++++++++++++++
>  arch/arm/mach-omap2/display.c                      |  1 +
>  .../omap2/displays-new/panel-tpo-td028ttec1.c      | 33 ++++++++-
>  4 files changed, 149 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/video/toppoly,td028ttec1.txt
>
> --
> 1.8.3.2
>

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
