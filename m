From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 23 Feb 2011 13:33:26 +0000
Subject: Re: [PATCH] OMAP2/3/4: DSS2: Enable Display SubSystem as modules
Message-Id: <1298468006.18466.37.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298463753-24880-1-git-send-email-samreen@ti.com>
In-Reply-To: <1298463753-24880-1-git-send-email-samreen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On Wed, 2011-02-23 at 06:22 -0600, Nilofer, Samreen wrote:
> Enabling Display options to be built as modules
> Also, the generic dpi, sharp & nec panels are also
> enabled as modules.

I've just posted a patch which fixes the problem with the regulators in
DSS. With that patch we can safely enable all DSS interfaces (and thus
panels) and the resulting binary will work on all boards.

So can you make one more version which enables all the interfaces and
panels as modules, based on
git://gitorious.org/linux-omap-dss2/linux.git master

 Tomi


