From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Patch to add mode setting to sysfs
Date: Thu, 17 Feb 2005 22:13:32 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502172210030.10099@pentafluge.infradead.org>
References: <9e4733910502161430ff1dad1@mail.gmail.com> 
 <200502172150.16256.adaplas@hotpop.com> <9e47339105021712494955212d@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1tu3-0001hB-Fs
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 14:13:43 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1tu1-0003Mr-HA
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 14:13:43 -0800
In-Reply-To: <9e47339105021712494955212d@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: adaplas@pol.net, James Simmons <jsimmons@pentafluge.infradead.org>, linux-fbdev-devel@lists.sourceforge.net



> On Thu, 17 Feb 2005 21:50:16 +0800, Antonino A. Daplas
> <adaplas@hotpop.com> wrote:
> > Instead of hardcoding some of the fields in var, why not
> > copy it from the current var?  Ie:
> > 
> > var = info->var;
> > fb_videomode_to_var(&var, mode);
> 
> I added this change, plus more robust error handing. Add attributes
> for virtual resolution and bpp.
> 
> I also fixed fb so that it works as module.

Seperate the make fbdev modular into another patch. Also I have a feeling 
that will open a whole new can of worms. Also please create something 
like

static struct attribute *frame_attrs[] = {
	&class_device_attr_dev.attr,
	&class_device_attr_name.attr,
	NULL
};

and do 

for (i = 0; i < ARRAY_SIZE(frame_class_device_attributes); i++) {
               rc = class_device_create_file(&info->class_dev, frame_class_device_attributes[i]);
               if (unlikely(rc)) {
                       /* Not fatal */
                       printk(KERN_WARNING "Unable to create device file  for framebuffer %d\n", info->node);
             }
       }


Did you see me email with my ideas about the sysfs structure?



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
