From: Rajendra Nayak <rnayak@ti.com>
Date: Tue, 26 Jun 2012 07:48:38 +0000
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Message-Id: <4FE96686.6000002@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>				
 <1340372890-10091-6-git-send-email-rnayak@ti.com>			
 <1340604478.12683.25.camel@lappyti> <4FE80C43.6090802@ti.com>		
 <1340611133.3395.3.camel@deskari> <4FE85005.4090303@ti.com>	
 <1340630090.3395.85.camel@deskari> <4FE941EA.7050108@ti.com>
 <1340693758.2093.15.camel@lappyti>
In-Reply-To: <1340693758.2093.15.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 26 June 2012 12:25 PM, Tomi Valkeinen wrote:
> On Tue, 2012-06-26 at 10:30 +0530, Rajendra Nayak wrote:
>
>>> So as far as I see, clocks are never handled in atomic context. Is
>>> everything related to the base clk stuff already in mainline? Can I take
>>> the clk_prepare/unprepare patch into my omapdss tree?
>>
>> Well the Common Clk framework is already in mainline, but we still don;t
>> have CONFIG_COMMON_CLK enabled for our builds yet. So until we do so,
>> clk_prepare/unprepare will just be stubs which do nothing.
>
> But if I understood correctly, clk_prepare and clk_unprepare are anyway
> no-ops with dss clocks, even when CONFIG_COMMON_CLK is enabled?

With CONFIG_COMMON_CLK enabled, they will do prepare use-counting with
a mutex lock/unlock around it.

>
> My point was only to understand if I can safely take the patch into
> omapdss tree, instead of it going through l-o, to avoid any possible
> conflicts.

yes, I don't see any issues with it going through dss tree.

>
>   Tomi
>

