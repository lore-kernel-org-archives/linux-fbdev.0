From: Jiada Wang <jiada_wang@mentor.com>
Subject: DRM/KMS/FB: HDMI hotplug displays 1024x768 resolution instead of
 native mode
Date: Wed, 19 Jun 2013 16:37:56 +0900
Message-ID: <51C15FD4.4060201@mentor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-arm-kernel@lists.infradead.org, airlied@redhat.com, linux-fbdev-devel@lists.sourceforge.net
Cc: Jiada Wang <jiada_wang@mentor.com>

Hi,

I am implementing HDMI hotplug feature for i.MX6 platform,
the basic function has already been done and works

But there is is an "issue",
When bootup system without HDMI cable attached, fbcon is initialised 
with fbsize: 1024x768, after plug-in HDMI cable, I can see in debug log,
display's valid video_mode has been read via DDC, but in 
drm_fb_helper_hotplug_event(), only size lower than 
fb_helper->fb->width/fb_helper->fb->height, will be accepted,

So instead of the display's native mode, 1024x768 is displayed.

Is it correct DRM/fbdev behaviour?



Thanks,
Jiada
