From: Archit Taneja <a0393947@ti.com>
Date: Fri, 31 Aug 2012 12:46:51 +0000
Subject: Re: [PATCH v2 06/23] OMAP_VOUT: Remove manager->device references
Message-Id: <5040AF6B.7020003@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345528711-27801-1-git-send-email-archit@ti.com>  <1346326845-16583-1-git-send-email-archit@ti.com>  <1346326845-16583-7-git-send-email-archit@ti.com> <1346415118.18766.15.camel@lappyti>
In-Reply-To: <1346415118.18766.15.camel@lappyti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

On Friday 31 August 2012 05:41 PM, Tomi Valkeinen wrote:
> On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
>> With the introduction of output entities, managers will now connect to outputs.
>> Use the helper op for managers named get_device. This will abstract away the
>> information on how to get the device from an overlay manager.
>>
>> Using the helper function will reduce the number of pointer dereferences a user
>> of OMAPDSS needs to do and reduce risk of a NULL dereference.
>
> Almost all the uses here seem to be getting the dssdev from an overlay.
> Would it make sense to implement get_device for an ovl? That would
> reduce all the ovl->manager ? ovl->manager->get_device(ovl->manager) :
> NULL; code to ovl->get_device(ovl).

That make sense.

We would still need mgr->get_device() though, as in some places, dss and 
drm try to get the display from the manager.

Archit

