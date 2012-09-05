From: Archit Taneja <a0393947@ti.com>
Date: Wed, 05 Sep 2012 11:46:28 +0000
Subject: Re: [PATCH 12/17] OMAPDSS: clean up dss_mgr_set_timings
Message-Id: <504738C4.7060005@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>  <1346833555-31258-13-git-send-email-tomi.valkeinen@ti.com>  <5047182F.3030507@ti.com> <1346841713.32747.6.camel@deskari>
In-Reply-To: <1346841713.32747.6.camel@deskari>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 05 September 2012 04:11 PM, Tomi Valkeinen wrote:
> On Wed, 2012-09-05 at 14:45 +0530, Archit Taneja wrote:
>> On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
>>> dss_mgr_set_timings() can only be called when the output is not active.
>>> This means that most of the code in the function is extra, as there's no
>>> need to write the values to registers, etc, because that will be handled
>>> when the output will be enabled.
>>
>> We need to fix dpi_set_timings() before we can make this change. DPI
>> still tries to change timings on the fly, i.e, with manager enabled. We
>> need to disable and enable the DPI output like we do for other outputs.
>
> Yep, and for HDMI also (I didn't check the others yet).

I don't think HDMI is impacted, we do the full power off and power on 
for HDMI, so the manager would be disabled when we set the timings.

>
> I think the simplest way to handle this is to only write the dpi.timings
> in omapdss_dpi_set_timings, and remove the call to dss_mgr_set_timings.
> This is not perfect, as a call to omapdss_dpi_set_timings when the
> display is enabled would result in changing the dpi.timings, but the
> changes wouldn't be actually in use.

The simplest way would be to do what other outputs do, disable the 
output and re-enable the output with the new timings value, if the panel 
is enabled.

Archit

