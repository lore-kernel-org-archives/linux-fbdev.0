From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH]
Date: Thu, 22 Feb 2007 09:03:54 +0800
Message-ID: <1172106234.4217.50.camel@daplas>
References: <Pine.LNX.4.64.0702212105280.20620@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK2KW-00026f-F6 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:01:04 -0800
Received: from nz-out-0506.google.com ([64.233.162.229])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK2KV-0003n3-0S
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:01:04 -0800
Received: by nz-out-0506.google.com with SMTP id i11so24951nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Feb 2007 17:01:02 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702212105280.20620@pentafluge.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2007-02-21 at 21:23 +0000, James Simmons wrote:
> This is the new display intreface. Its goal is to provide a standard 
> interface to various types of displays. Currently we have auxdisplay, 
> output acpi device and the now defunct lcd class in the backlight directory.
> Please apply.

Is this an attempt to consolidate all display hardware and drivers?

> 
[snip]
> +struct class *display_class;
> +EXPORT_SYMBOL(display_class);
> +static int index;
> +
> +struct display_device *display_device_register(struct display_driver *driver,
> +						struct device *dev, void *devdata)
> +{
> +	struct display_device *new_dev = NULL;
> +	int ret = -EINVAL;
> +
> +	if (unlikely(!driver))
> +		return ERR_PTR(ret);
> +
> +	new_dev = kzalloc(sizeof(struct display_device), GFP_KERNEL);
> +	if (likely(new_dev) && unlikely(driver->probe(new_dev, devdata))) {
> +		new_dev->dev = device_create(display_class, dev, 0,
> +						"display%d", index);
> +
> +		if (!IS_ERR(new_dev->dev)) {
> +			dev_set_drvdata(new_dev->dev, new_dev);
> +			new_dev->driver = driver;
> +			new_dev->parent = dev;
> +			mutex_init(&new_dev->lock);
> +			index++;
> +		} else {
> +			new_dev->dev = NULL;
> +			kfree(new_dev);

Set new_dev to NULL on failure.

> +		}
> +	}
> +	return new_dev;
> +}
> +EXPORT_SYMBOL(display_device_register);
> +
> +void display_device_unregister(struct display_device *ddev)
> +{
> +	if (!ddev)
> +		return;
> +	mutex_lock(&ddev->lock);
> +	device_del(ddev->dev);
> +	ddev->driver = NULL;
> +	index--;

display0
display1
index = 2
unregister display0
index = 1
display_device_register() as device1
device1 <-- BUG, already used.

[snip]

> +
> +struct display_device;
> +
> +/* This structure defines all the properties of a Display. */
> +struct display_driver {
> +	int  (*set_contrast)(struct display_device *, unsigned int);
> +	int  (*get_contrast)(struct display_device *);
> +	void (*suspend)(struct display_device *, pm_message_t state);
> +	void (*resume)(struct display_device *);
> +	int  (*probe)(struct display_device *, void *);
> +	int  (*remove)(struct display_device *);
> +	int  max_contrast;

If this is an attempt to consolidate, I don't see the 'brightness'
hook of backlight and lcd.

If this is not a consolidation, why don't we just extend the lcd class?

Tony 



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
