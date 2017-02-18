From: Manuel =?ISO-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Date: Sat, 18 Feb 2017 09:47:09 +0000
Subject: Re: Potential NULL pointer dereference in drivers/video/fbdev/sis/init.c
Message-Id: <1487411229.14269.7.camel@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <22ff6151c00b3abef040afcd601c6b76@cs.utah.edu>
In-Reply-To: <22ff6151c00b3abef040afcd601c6b76@cs.utah.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Hi Shaobo,

On Sat, 2017-02-18 at 00:26 -0700, Shaobo wrote:
> I am applying a static analysis tool to the Linux device drivers and
> got 
> an error trace of null pointer dereference in 
> drivers/video/fbdev/sis/init.c starting from function 
> SiS_SetCRT1FIFO_630: pointer `queuedata` is initialized to NULL at
> line 
> 2409 and could get dereferenced at line 2501 if ModeNo <= 0x13 and 
> SiS_Pr->ChipType = SIS_730. To be more specific, if ModeNo <= 0x13
> then 
> the locations (line 2449 or line 2451)where `queuedata` gets updated
> to 
> a non null value is skipped. And if `SiS_Pr->ChipType = SIS_730`,
> then 
> `queuedata` is dereferenced. As you can see, the error trace is only 
> plausible since it depends on certain conditions. Therefore, I was 
> wondering if you could confirm it.
Thanks for your analysis! I agree with your static code analysis and
there is a potential NULL dereference.

Please note that I am not really familiar with the details of this
driver, so I am not sure what the code SHOULD look like and if this
potential dereference can really occur at runtime.

Maybe somebody else with a little bit more insight into the details of
this driver might want to comment on this?

Bye,

Manuel

