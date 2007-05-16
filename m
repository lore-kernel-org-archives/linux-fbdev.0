From: "Diego A. Fons" <diegofons-YHmT1Vw44LrQT0dZR+AlfA@public.gmane.org>
Subject: Problem with FB
Date: Wed, 16 May 2007 13:45:27 -0300
Message-ID: <464B3527.4080406@apexar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <buildroot-bounces-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://busybox.net/mailman/listinfo/buildroot>,
	<mailto:buildroot-request-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://busybox.net/lists/buildroot>
List-Post: <mailto:buildroot-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:buildroot-request-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <http://busybox.net/mailman/listinfo/buildroot>,
	<mailto:buildroot-request-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: buildroot-bounces-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org
Errors-To: buildroot-bounces-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org
To: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: buildroot-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org

Hi,

First of all i'm not sure if it is the correct list for posting this 
mail, if it's not, please tell me wich list is the correct one.

I'm working on an embedded device (a Ronetix pm9261 board with an 
AT91SAM9261 cpu), i could build the linux kernel version 2.6.19.7 with 
framebuffer support and it works fine. The problem is when i run any 
command that uses net services, i.e. when i run sftp the sreen moves and 
it kept like this, the offset (0,0) is in position (100,0) (it's just an 
example, i don't know thw correct values) and i'm not able to correct 
it. It occurs every time i run a net comand. The display i'm usin is a 
LCD and the driver is sidsab.c.

Thank you for your time and i'll be waiting any suggestions.

Regards,
Diego A. Fons.
