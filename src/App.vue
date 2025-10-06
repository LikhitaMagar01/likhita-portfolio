<script setup lang="ts">
import { ref } from 'vue'
import profile from './data/profile'
import BottomBar from './components/BottomBar.vue'

const selectedSection = ref('home')

function handleSectionChange(section: string) {
  selectedSection.value = section
}
</script>

<template>
  <div class="min-h-screen bg-gray-900 text-white flex flex-col items-center justify-center p-4 relative">
    <div class="w-[1200px] m-auto">
      <div class="flex flex-col md:flex-row items-center justify-center">
        <div
          class="relative bg-gray-800 border border-gray-600 rounded-3xl shadow-2xl p-0 w-full max-w-xs flex flex-col items-center mb-8 md:mb-0 md:mr-12 md:h-full min-h-[500px] md:min-h-0 md:justify-between overflow-hidden">
          <div class="absolute right-0 top-6 bottom-6 w-1 bg-green-500 rounded-full"></div>
          <div class="flex flex-col items-center w-full px-6 py-6 z-10 h-[65vh]">
            <img :src="profile.image" alt="Profile"
              class="rounded-lg w-28 h-28 object-cover mb-4 border-4 border-gray-700" />
            <h2 class="text-lg font-bold">{{ profile.name }}</h2>
            <p class="text-green-400 text-sm">{{ profile.title }}</p>
            <div class="flex space-x-3 my-4">
              <a v-for="s in profile.social" :key="s.icon" :href="s.url" target="_blank"
                class="text-gray-400 hover:text-green-400 text-lg">
                <i v-if="s.icon === 'fa-github'" class="ri-github-fill"></i>
                <i v-if="s.icon === 'fa-instagram'" class="ri-instagram-fill"></i>
                <i v-if="s.icon === 'fa-linkedin'" class="ri-linkedin-box-fill"></i>
              </a>
            </div>
            <div class="text-xs text-gray-300 mb-1">{{ profile.email }}</div>
            <div class="text-xs text-gray-300 mb-3">{{ profile.location }}</div>
            <button
              class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg w-full font-semibold flex items-center justify-center gap-2">
              <svg style="width: 24px; height: 24px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M3 3H21C21.5523 3 22 3.44772 22 4V20C22 20.5523 21.5523 21 21 21H3C2.44772 21 2 20.5523 2 20V4C2 3.44772 2.44772 3 3 3ZM12.0606 11.6829L5.64722 6.2377L4.35278 7.7623L12.0731 14.3171L19.6544 7.75616L18.3456 6.24384L12.0606 11.6829Z"></path></svg> {{ profile.contactButton }}
            </button>
            <div class="text-[10px] text-gray-500 mt-4">{{ profile.copyright }}</div>
          </div>
        </div>
        <div class="flex flex-col items-center justify-center">
          <div class="flex flex-col justify-between items-start max-w-2xl w-[80vh] md:h-full min-h-[500px] md:min-h-0">
            <section v-if="selectedSection === 'home'" class="flex flex-col gap-4 w-full h-[50vh] overflow-y-auto">
              <div class="text-gray-400 text-sm">Introduction</div>
              <h1 class="text-3xl sm:text-4xl md:text-5xl font-bold">
                {{ profile.intro }}
                <span class="text-green-400">{{ profile.highlightedName }}</span>,<br>
                <span v-for="(role, i) in profile.roles" :key="role">
                  {{ role }}<span v-if="i < profile.roles.length - 1"> and </span>
                </span>
              </h1>
              <p class="text-gray-300">{{ profile.description }}</p>
            </section>
            <section v-if="selectedSection === 'about'" class="flex flex-col gap-4 w-full h-[50vh] overflow-y-auto">
              <h2 class="text-2xl font-bold mb-2">About Me</h2>
              <p class="text-gray-300 mb-4">
                Hi! I'm Likhita Magar, a passionate Software Engineer based in Lalitpur, Nepal. I specialize in building modern, responsive, and accessible web applications with a focus on clean design and great user experience.<br><br>
                With a strong foundation in JavaScript, TypeScript, and frameworks like Vue.js and React, I enjoy turning complex problems into simple, beautiful, and intuitive solutions. My experience spans across frontend development, and I love collaborating with teams to bring ideas to life.
              </p>
              <h3 class="text-lg font-semibold mb-1 text-green-400">Skills & Tools</h3>
              <ul class="list-disc list-inside text-gray-400 mb-4">
                <li>JavaScript, TypeScript, HTML5, CSS3</li>
                <li>Vue.js, Nuxt.js, React, Next.js, Tailwind CSS, vuetify, </li>
                <li>Git, GitHub</li>
                <li>Responsive & Mobile-First Design</li>
                <li>Webpack</li>
              </ul>
              <p class="text-gray-400 mb-3">
                Beyond coding, I enjoy learning new technologies, contributing to open source, and sharing knowledge
                with the community. When I'm not at the computer, you'll find me cooking, reading, or
                with my guitar.<br><br>
                <span class="text-green-400 font-semibold">Let's build something amazing together!</span>
              </p>
            </section>
            <section v-if="selectedSection === 'education'" class="flex flex-col gap-4 w-full h-[50vh] overflow-y-auto">
              <div class="flex items-center mb-2">
                <span class="bg-[#23252B] text-xs px-3 py-1 rounded-full text-gray-400 border border-gray-600">Education</span>
              </div>
              <h2 class="text-3xl font-bold mb-8">Education</h2>
              <div class="relative pl-10">
                <div class="relative">
                  <template v-for="(item, idx) in profile.education" :key="'edu-' + idx">
                    <div v-if="item && idx < profile.education.length - 1" class="flex items-start mb-10">
                      <div class="flex flex-col items-center mr-6">
                        <div class="w-3 h-3 bg-green-400 rounded-full border-2 border-[#181A20]"></div>
                        <div class="flex-1 w-0.5 bg-gray-700" style="min-height: 40px;"></div>
                      </div>
                      <div>
                        <div class="text-xs text-gray-400">{{ item.date }}</div>
                        <div class="text-lg font-semibold text-white leading-tight">{{ item.title }}</div>
                        <div v-if="'subtitle' in item && item.subtitle" class="text-xs text-gray-500">{{ item.subtitle }}</div>
                      </div>
                    </div>
                    <div v-else-if="item" class="flex items-start">
                      <div class="flex flex-col items-center mr-6">
                        <div class="w-3 h-3 bg-green-400 rounded-full border-2 border-[#181A20]"></div>
                        <div class="flex-1 w-0.5 bg-gray-700" style="min-height: 40px;"></div>
                      </div>
                      <div>
                        <div class="text-xs text-gray-400">{{ item.date }}</div>
                        <div class="text-lg font-semibold text-white leading-tight">{{ item.title }}</div>
                        <div v-if="'subtitle' in item && item.subtitle" class="text-xs text-gray-500">{{ item.subtitle }}</div>
                      </div>
                    </div>
                  </template>
                </div>
              </div>
            </section>
            <section v-if="selectedSection === 'experience'" class="flex flex-col gap-4 w-full h-[50vh] overflow-y-auto">
              <div class="flex items-center mb-2">
                <span class="bg-[#23252B] text-xs px-3 py-1 rounded-full text-gray-400 border border-gray-600">Experience</span>
              </div>
              <h2 class="text-3xl font-bold mb-8">Experience</h2>
              <div class="relative pl-10">
                <div class="relative">
                  <template v-for="(item, idx) in profile.experience" :key="'exp-' + idx">
                    <div v-if="item && idx < profile.experience.length - 1" class="flex items-start mb-10">
                      <div class="flex flex-col items-center mr-6">
                        <div class="w-3 h-3 bg-green-400 rounded-full border-2 border-[#181A20]"></div>
                        <div class="flex-1 w-0.5 bg-gray-700" style="min-height: 40px;"></div>
                      </div>
                      <div>
                        <div class="text-xs text-gray-400">{{ item.date }}</div>
                        <div class="text-lg font-semibold text-white leading-tight">{{ item.title }}</div>
                        <div v-if="'company' in item && item.company" class="text-xs text-green-400 font-semibold">{{ item.company }}</div>
                      </div>
                    </div>
                    <div v-else-if="item" class="flex items-start">
                      <div class="flex flex-col items-center mr-6">
                        <div class="w-3 h-3 bg-green-400 rounded-full border-2 border-[#181A20]"></div>
                        <div class="flex-1 w-0.5 bg-gray-700" style="min-height: 40px;"></div>
                      </div>
                      <div>
                        <div class="text-xs text-gray-400">{{ item.date }}</div>
                        <div class="text-lg font-semibold text-white leading-tight">{{ item.title }}</div>
                        <div v-if="'company' in item && item.company" class="text-xs text-green-400 font-semibold">{{ item.company }}</div>
                      </div>
                    </div>
                  </template>
                </div>
              </div>
            </section>
            <section v-if="selectedSection === 'projects'" class="w-full h-[50vh] overflow-y-auto">
              <h2 class="text-2xl font-bold mb-2">Projects</h2>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6 my-4">
                <div v-for="project in profile.projects" :key="project.name" class="bg-gray-800 rounded-xl p-4 shadow flex flex-col gap-2">
                  <h3 class="text-lg font-semibold text-green-400">{{ project.name }}</h3>
                  <p class="text-gray-300 text-sm">{{ project.description }}</p>
                  <a :href="project.link" target="_blank" class="text-xs text-green-400 hover:underline">View Project</a>
                </div>
              </div>
            </section>
            <section v-if="selectedSection === 'skills'" class="w-full h-[50vh] overflow-y-auto">
              <h2 class="text-2xl font-bold mb-2">Skills</h2>
              <div class="flex flex-wrap gap-6 items-center mt-4">
                <div v-for="skill in profile.skills" :key="skill.name" class="flex flex-col items-center">
                  <img :src="skill.icon" :alt="skill.name" class="w-12 h-12 mb-1" />
                  <span class="text-xs mt-1">{{ skill.name }}</span>
                </div>
              </div>
            </section>
            <section v-if="selectedSection === 'contact'" class="w-full h-[50vh] overflow-y-auto">
              <h2 class="text-2xl font-bold mb-2">Contact</h2>
              <div class="mb-4 space-y-2">
                <div v-for="contact in profile.contacts" :key="contact.type" class="flex items-center">
                  <i :class="[contact.icon, 'text-green-400 mr-2']"></i>
                  <template v-if="contact.link">
                    <a :href="contact.link" class="text-green-400 hover:underline" target="_blank">{{ contact.value }}</a>
                  </template>
                  <template v-else>
                    <span class="text-gray-300">{{ contact.value }}</span>
                  </template>
                </div>
              </div>
            </section>
          </div>
          <div class="w-full flex justify-center">
            <BottomBar :selectedSection="selectedSection" @section-change="handleSectionChange" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
section.overflow-y-auto {
  scrollbar-width: thin;
  scrollbar-color: #222 #111;
}

section.overflow-y-auto::-webkit-scrollbar {
  width: 8px;
  background: #111;
}

section.overflow-y-auto::-webkit-scrollbar-thumb {
  background: #222;
  border-radius: 6px;
}
</style>
