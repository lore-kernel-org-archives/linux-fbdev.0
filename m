From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] sh: SuperH Mobile suspend support V3
Date: Mon, 16 Mar 2009 20:00:40 +0900
Message-ID: <20090316110039.GB21433@linux-sh.org>
References: <20090313153655.20515.14828.sendpatchset@rx1.opensource.se> <20090313152714.20494.42365.sendpatchset@rx1.opensource.se> <20090313152304.20487.42793.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090313153655.20515.14828.sendpatchset@rx1.opensource.se> <20090313152714.20494.42365.sendpatchset@rx1.opensource.se> <20090313152304.20487.42793.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, francesco.virlinzi@st.com, linux-fbdev-devel@lists.sourceforge.net

On Sat, Mar 14, 2009 at 12:23:04AM +0900, Magnus Damm wrote:
> This patch contains CONFIG_SUSPEND support to the SuperH
> architecture V3. If enabled, SuperH Mobile processors will
> register their suspend callbacks during boot.
> 
> To suspend, use "echo mem > /sys/power/state". To allow
> wakeup, make sure "/sys/device/platform/../power/wakeup"
> contains "enabled". Additional per-device driver patches
> are most likely needed.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

On Sat, Mar 14, 2009 at 12:27:14AM +0900, Magnus Damm wrote:
> Improve the ap325 board code to allow the lcd panel
> and backlight to be powered off.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

On Sat, Mar 14, 2009 at 12:36:55AM +0900, Magnus Damm wrote:
> This patch adds suspend/resume support to the LCDC
> driver for SuperH Mobile - sh_mobile_lcdcfb.
> 
> We simply stop hardware on suspend and start it again
> on resume. For RGB panels this is trivial, but for SYS
> panels in deferred io mode this becomes a bit more
> difficult - we need to wait for a frame end interrupt
> to make sure the clocks are balanced before stopping
> the actual hardware.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

All applied, thanks.
