From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 18 Dec 2015 20:41:46 +0000
Subject: Re: [PATCH v6 1/2] video: fbdev: pxafb: loosen the platform data bond
Message-Id: <871tajij5h.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449955631-14955-1-git-send-email-robert.jarzmik@free.fr>
	<56701430.9050100@ti.com>
In-Reply-To: <56701430.9050100@ti.com> (Tomi Valkeinen's message of "Tue, 15
	Dec 2015 15:22:56 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On 12/12/15 23:27, Robert Jarzmik wrote:
>> In order to prepare the transition to a mixed platform data and
>> device-tree initialization, remove all the platform data references all
>> over the driver.
>> 
>> Copy the platform data into the internal structure of the pxafb, and
>> only use this afterward.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>>  drivers/video/fbdev/pxafb.c | 54 ++++++++++++++++++++++++++++-----------------
>>  drivers/video/fbdev/pxafb.h |  2 ++
>>  2 files changed, 36 insertions(+), 20 deletions(-)
>
> Thanks, I've queued this and the second patch for 4.5.
Excellent, thank you.

Cheers.

-- 
Robert
