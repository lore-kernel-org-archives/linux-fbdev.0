From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Date: Tue, 07 Aug 2012 12:48:31 +0000
Subject: Re: [PATCH 4/6] OMAPDSS: VENC: Remove cpu_is_xxxx checks
Message-Id: <50210BCF.20100@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1343912532.git.cmahapatra@ti.com> <75e516de4cb0787d52e4a9173d123df6903d561a.1343912533.git.cmahapatra@ti.com> <20120807085103.GM8468@arwen.pp.htv.fi>
In-Reply-To: <20120807085103.GM8468@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tuesday 07 August 2012 02:21 PM, Felipe Balbi wrote:
> On Tue, Aug 07, 2012 at 01:58:17PM +0530, Chandrabhanu Mahapatra wrote:
>> OMAP4 checks are removed from VENC to provide it a cleaner interface. These
>> checks were introduced by patches "HACK: OMAP: DSS2: VENC: disable VENC on OMAP4
>> to prevent crash" (ba02fa37de) by Tomi Valkeinen <tomi.valkeinen@ti.com> and
>> "OMAPDSS: VENC: fix NULL pointer dereference in DSS2 VENC sysfs debug attr on
>> OMAP4" (cc1d3e032d)  by Danny Kukawka <danny.kukawka@bisect.de> to prevent VENC
>> from crashing OMAP4 kernel. An alternative approach is used to do the same in
>> later patches.
> in later patches ? This means you're causing a regression here. Just
> swap the patches around to avoid it.
>
Hi! Yes I do agree with you. But as VENC is disabled on omap4, the basic
idea here was to remove unnecessary cpu_is checks and achieve the same
through a better approach.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.

